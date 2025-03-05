Return-Path: <linux-kernel+bounces-546244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556A4A4F84D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846F8188BAC7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9DE1F3D30;
	Wed,  5 Mar 2025 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVg3l7GN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6917555;
	Wed,  5 Mar 2025 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741161216; cv=none; b=uAN66S5cYDSQFd/tmU8tW4CwsRoHYRDqXC7fONhx8kVnrVPpMqOno0lYnNHxYYuaImu81JVaBA7zaP6cQszeqQAzhTwvT8krnfZEref0RIcmpbHqrM7eiSs+2cTA+6FtHsAfYlJpCK99KHjeu6S4Cn5Zf0A0PJZpEaEX789B5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741161216; c=relaxed/simple;
	bh=UdDuY5iEXlf8q1wJO/ji2TRa9vQXVqeswfiZfCyhuvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NsGRkhSdfag8Vp1gMUuiO0uq9nEy4KY5ZvFuItV8+Vmkj3qDuh3O3KIIBcqrg4TCJV5c9YV/FfXGXQsEeRVQwQ1lmiNpQu24zhc718BAyYzo2sBtl95v5/efLEsRNCao0d7zaYS3ek+wM3RJ5HFQ4wGT4W9Wh0TPri3wnJn7suY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVg3l7GN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A44C4CEE2;
	Wed,  5 Mar 2025 07:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741161214;
	bh=UdDuY5iEXlf8q1wJO/ji2TRa9vQXVqeswfiZfCyhuvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lVg3l7GNo1Zb5vn9tfnZoG8447kx9Ux4Z8kV1zkKX2iJYy57cZBcl3Q/GVUxrDlzT
	 gczUa/Ws4rryTHXP8c7ZYJBYbwN8tEGomUgsiJx+e6Nl/A+3l4Rgl8lmNDsy8dqnkv
	 ChwuCkPfiL1WAUmJSARhJgI/msxO+tTl2e0l7fN7ngjCE4algzVT6ist1O8ug3Zv8U
	 OYI+Xhe+XVA3ImJdT3unRSxDsFK5UOlaOso/lB097J+VquzoOTqHn+20wz0OZFi4Ml
	 pXJ6VGrnJ3NKNpK/lgEmErju78u32qdX81eAaElHL9TbjNjo5FJWNt/G9dXh8SR+7o
	 TCrI0kXC3ORKw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com>,
  <alex.gaynor@gmail.com>,  <aliceryhl@google.com>,  <apw@canonical.com>,
  <arnd@arndb.de>,  <aswinunni01@gmail.com>,  <axboe@kernel.dk>,
  <benno.lossin@proton.me>,  <bhelgaas@google.com>,
  <bjorn3_gh@protonmail.com>,  <boqun.feng@gmail.com>,  <dakr@kernel.org>,
  <dwaipayanray1@gmail.com>,  <ethan.twardy@gmail.com>,
  <fujita.tomonori@gmail.com>,  <gary@garyguo.net>,
  <gregkh@linuxfoundation.org>,  <joe@perches.com>,
  <linux-kernel@vger.kernel.org>,  <lukas.bulwahn@gmail.com>,
  <ojeda@kernel.org>,  <pbonzini@redhat.com>,
  <rust-for-linux@vger.kernel.org>,  <tmgross@umich.edu>,
  <walmeida@microsoft.com>
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
In-Reply-To: <CANiq72kNG7jZf+hZARjyAp-uG=x99CrUKZvJYT_icaF0x0G6iw@mail.gmail.com>
 (Miguel
	Ojeda's message of "Tue, 04 Mar 2025 22:01:05 +0100")
References: <87tt89gfe4.fsf@kernel.org>
	<20250304205054.207285-1-trintaeoitogc@gmail.com>
	<CANiq72koDba445gMYtC_VEcFk2+O-Xg2-2y6uMyp7onBy=7rcw@mail.gmail.com>
	<4D_uEoEtgYCzOLuPzhX9Vs7J1uScCFl9I8iUfPXkglvk62R7uBUyCd-_o9rqmINGO1eVIm5gGyfC2_25bhigHQ==@protonmail.internalid>
	<CANiq72kNG7jZf+hZARjyAp-uG=x99CrUKZvJYT_icaF0x0G6iw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 08:53:18 +0100
Message-ID: <87v7sngbgx.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Tue, Mar 4, 2025 at 10:00=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> I think it could be a good idea (it would be lovely to write the
>> checker in Rust -- I also had a checker bot in Python from the old
>> days of the old `rust` branch in GitHub), but `checkpatch.pl` doesn't
>> need a built kernel, so it would be a disadvantage or at least a
>> difference w.r.t. the usual `checkpatch.pl`, and we may not be able to
>> call it from `checkpatch.pl`.
>
> By "built kernel", I don't mean an entire kernel, but rather having to
> call `make` in general, i.e. we could have a target to build just the
> script, but still, it is a difference.

Right, it needs a bit more tool support than running checkpatch.pl
needs. Perhaps we could move it from checkpatch.pl to the rustfmt make
target?


Best regards,
Andreas Hindborg




