Return-Path: <linux-kernel+bounces-363681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D934C99C591
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161931C22B38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1A51586CF;
	Mon, 14 Oct 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQCMu73i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A759015821A;
	Mon, 14 Oct 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897966; cv=none; b=RE61Pm8uSXSceK+OT3YCnrQsdScX2kWHJrtCZl1EwmoApx9SXLLCeCUlkGOy5b1xeneTSNB30p9v82NYFnCFlHDEe3+qyCId7fa9mRJx1gx0m1FKxxsSp9exmUCxN4LFnHu4SoQwqcCn/iEvZNpzaX75CGLFKAPkLnkeWz1HmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897966; c=relaxed/simple;
	bh=w0+Cqw0mJHdofaP5FQwQ8u5fizWY9MZm7LMFDhyo/UA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECUBx31AyIs0fGIPrWvWIwFauxHd7cSfOhdzvETTemrekIa8R05B53dxSBVO832hB9pzgnEIWAbZ6uzR0fwKDeYGKBDJu+VXuiIOk5zYAGF+LntS6xGoB2r/1HXNUjCl0p+h4PE+BzEV1Zaou6EXtWnYyVDPVoFwXJCuBn8/BOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQCMu73i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F19EC4CEC7;
	Mon, 14 Oct 2024 09:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728897966;
	bh=w0+Cqw0mJHdofaP5FQwQ8u5fizWY9MZm7LMFDhyo/UA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BQCMu73io/Tmhxq+Iej/akoEQhy6ZpoZV1QxK+yMvjM0KSwRMEH0IDBfvtSvFNhao
	 VPBC+8siPJqhKMmUH/4aRDtkuIQB/h8Q/GI5qf3e390qQjEQnToWSvyqe62kPWo12r
	 sfrp4xSoQ4uTdfaK2Se/3IxW5XROOrq+o3NOwzJU2reZLwprwTiZciuwkUg0ysotvK
	 xghhsp8VsKXJWFwCQRiVf324pWCVh9tBmHu+GQCFfWTrKnHraQCxtZyH4SSZfbhjAt
	 gsD/BYTcm3YpG4QDgWnx+M+QyrC/mVLwIzpVapo8neXzYJkEVbTyteeeLh047GPWf7
	 1MZkUWmc10kDg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rust: add global lock support
In-Reply-To: <2376e7b3-42a4-4743-a5cd-83251dcc0075@proton.me> (Benno Lossin's
	message of "Thu, 10 Oct 2024 22:14:52 +0000")
References: <20240930-static-mutex-v4-1-c59555413127@google.com>
	<HVPdDHj35lGMPHyA8YvYjO4hhof-vNaVDqo_ILwyCmuY13oskqVKxaIA7OK4wo6fWYeJIV_RMtbPdjVRGJcLvg==@protonmail.internalid>
	<1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me>
 <87msjckqfw.fsf@kernel.org>
	<84WhswqN_2lGocLpK_symjkhVOPgJQHGCnU6LbFRZ_YgY_hQsHtdHZe6yTB9XaShz4Cmym_AdOBXm4qSzkAyAg==@protonmail.internalid>
	<2376e7b3-42a4-4743-a5cd-83251dcc0075@proton.me>
Date: Fri, 11 Oct 2024 16:57:47 +0200
Message-ID: <875xpylmac.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 10.10.24 16:01, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>>
>>> Also,
>>>
>>>     error: type `__static_lock_ty_VALUE` should have an upper camel case name
>>>        --> rust/kernel/sync/lock/global.rs:100:18
>>>         |
>>>     100 |               type [< __static_lock_ty_ $name >] = $valuety;
>>>         |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: convert the identifier to upper camel case: `StaticLockTyValue`
>>>
>>
>> How did you manage to get these errors?
>
> I added a `global_lock!` invocation to `lib.rs`. Otherwise I also don't
> get them (they might also be emitted from the examples, but I didn't
> compile those).

I build the examples for kunit, but I did not get any warnings.
Interesting.

BR Andreas


