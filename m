Return-Path: <linux-kernel+bounces-525459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1E5A3F044
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC77188EB26
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D94204099;
	Fri, 21 Feb 2025 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFQm88om"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60962200136;
	Fri, 21 Feb 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130191; cv=none; b=n4CyK90XKXraIBDd/vDScg/81AIRkXfgIF3TaRo5FjvoQ4JHbs0p5ZL3WW4OoGIQYb4UvsZ6ukyzvHrCOFJRd1kzbElPpK63fqYpoDWtAN0wquBISDjnja88UG4y+4dUgNxJfrEv8hfl6v0NswRE5RIvYr2/wkgFbVq9Jiq7PXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130191; c=relaxed/simple;
	bh=jSFGUiq9JED1xzgk3rpGKc7M1sHXoxnKnQ7G38B4wqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o/P0ivg4X9+Ybyyk99qGHaoVSPJ/rWBclPQSbepZHln14G6WR2gmL+/S0LE5GpfqNu35hWWnRMzbsntqthDe9dt0oooPuN8CV7sVHbDTSsyrSjDBZQa/PZmMBZax4JgAyGfX+TFpj0R2CdBpQNL7KfXCUDJ7ECvC/EHkZ6WRHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFQm88om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D86CC4CED6;
	Fri, 21 Feb 2025 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740130190;
	bh=jSFGUiq9JED1xzgk3rpGKc7M1sHXoxnKnQ7G38B4wqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LFQm88om/4383Lrv/7Ek+dFeJIGasPorWjQednm2V47ECR+hIUSsBJbNu01GGwGr5
	 qdaW/9JWzlD0B0ep55us/9oNGiu/yESw3VLHYNgVB9dwxeZDWq/uZWJz038m6KhmKB
	 TeSypotvScoj+aEKTTkWDUpo8yP0JvIuKSy0WVtaFb3AEhp92vXzBgnrQdzOLhgS5X
	 QraER06aYtUC5LKWYKeKJJ76wwpEBH1ko0Yjz2cmkNrEzqn8XqyXw/Az1eJyg0ktm2
	 4IDjDrEzC0qciE9wwUsvVuplYISf61lomF28PmUbQu8XeqntX6AsYetTll2A4XOgvQ
	 YuN0aMtPc2GdA==
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
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <df748ac2-3551-460f-a16f-85d805671a3f@proton.me> (Benno Lossin's
	message of "Thu, 20 Feb 2025 23:46:10 +0000")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
	<1id7is_U22yzuGODgkUIoB5AFM6snF9CPu7F_sY7Mfkn3EwQRPfjB5JNkRFYu6DX1N8X_OQvdEB2BT-l3rFhwg==@protonmail.internalid>
	<df748ac2-3551-460f-a16f-85d805671a3f@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 10:05:11 +0100
Message-ID: <874j0nhdmg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 18.02.25 14:27, Andreas Hindborg wrote:
>> +
>> +    /// Cancel an initialized and potentially running timer.
>> +    ///
>> +    /// If the timer handler is running, this will block until the hand=
ler is
>> +    /// finished.
>> +    ///
>> +    /// Users of the `HrTimer` API would not usually call this method d=
irectly.
>> +    /// Instead they would use the safe `cancel` method on the [`HrTime=
rHandle`]
>
> Can you link to the `cancel` function?

Yes =F0=9F=91=8D


Best regards,
Andreas Hindborg



