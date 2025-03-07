Return-Path: <linux-kernel+bounces-551247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F27AA56A0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38F9189AAC0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94E721ADD6;
	Fri,  7 Mar 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwq9DzqJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CBB20DD79;
	Fri,  7 Mar 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356634; cv=none; b=W/b6OEAoZ6K2ULceGZHHCRqeVQCx7BpZ6JWEsfF7Zl3n++FDff8ugheVQTAeESSXfieaD68C9oJeHt495OW6PhdNm0qRsSqr6VL2laIX5ixu6kuey3KSgbiHQCa5mupo9Qv3rSgjJBB9jDCojfkk4kK1dvyGiGdsayTtclEs3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356634; c=relaxed/simple;
	bh=ycvlC3nIV+dXytq9GTZe1tNab5iTLWU4g4ZTuHLnR50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EdJDv2yMhObu8Gk+nooCX1l8a4/W4igOZkfAtx+g7Hq8Ghwc5omlRjnQzg+NgBGsR5OKeFBo68W4Y5v81mqMfMV69DTGqisquX4zEH8sLjTcBRIC7Uo9pcx3w1m/QtZeDX5zseQ1iDIuLFxz+TOYIYBmMc7CRQG/AgWnFdoLQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwq9DzqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055DBC4CED1;
	Fri,  7 Mar 2025 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741356633;
	bh=ycvlC3nIV+dXytq9GTZe1tNab5iTLWU4g4ZTuHLnR50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gwq9DzqJL5t7hUlnp+v8hTiL9P5ipKlZp3x5IpSkf4XjUPzVdE5RTRHQUzBxORK8j
	 DILV9UYkMSNeZx9tM4xYmEQMQnjLdqkgPG5aXLB5jvr4NFJZJofUTlaM83z1Ki1kqg
	 AQs91JlgAvrV5CEwJPuJuBdV0+f//IUMM1s0olgqRrnvC70RKY4PNDmn8F+3Pw06cP
	 312aKbKDgNEjguyiUMgTIC410Cd0uYXPDsgLdnGgtN4vG3br16dDYV9A2X2uw5EOuO
	 DysLdDh2CrVnI/NH7U8lb7N0LUKRvPvT0sI2yvTwucXvXZo7wWWPWjUKFF0Bp1OBnK
	 SyMI/Dw6K7wgQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  "Markus Elfring" <Markus.Elfring@web.de>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 13/13] rust: hrtimer: add maintainer entry
In-Reply-To: <D8A2IL07RV9S.6RF7B9326WFL@proton.me> (Benno Lossin's message of
	"Fri, 07 Mar 2025 13:28:42 +0000")
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
	<20250307-hrtimer-v3-v6-12-rc2-v10-13-0cf7e9491da4@kernel.org>
	<yjEvEAnF-Dbg6SaNzJ3fl8hPIP9ZNLn9E3q0DsSw82cD2JiGmg9dluQIu_cBTosDty_24DQ2O_XYA4Xvf5T8Aw==@protonmail.internalid>
	<D8A2IL07RV9S.6RF7B9326WFL@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 15:10:23 +0100
Message-ID: <875xkl3p9s.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>> Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Also
>> add Boqun Feng as reviewer.
>>
>> Acked-by: Boqun Feng <boqun.feng@gmail.com>
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>
> I don't recall adding my reviewed by for this patch (I normally don't
> review MAINTAINERS changes, since there isn't anything to review). And I
> don't find it in lore, how did this end up here?
>

Thanks for spotting this. It looks like I added your tag between v8 and
v9, and you are right, your tag for this patch does not appear on lore.

I had some trouble with b4 being too generous with the tags and I had to
revert to manual tagging. I think I messed this one up or did not manage
to revert the actions of b4.

I'll remove it.


Best regards,
Andreas Hindborg




