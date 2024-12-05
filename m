Return-Path: <linux-kernel+bounces-433916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6769E5EB5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D647016BE80
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450B22D4E2;
	Thu,  5 Dec 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="OHLw6czj"
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E561224B0F;
	Thu,  5 Dec 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426570; cv=none; b=RYps202q+hbH+kB397+48v/jk62VI81dCQyiKUui2dpUdD5BLbNVU83dHShKU62BITx/bfSQXNEb6jZWd5erEIVgsEBsv27KwGQf1EGKRG5eUlk5JPb6GjfZOxF89gLpOKsWP4T7N0tSVV1Cpd22VBCNsOZHXUo49hQ3URh6Ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426570; c=relaxed/simple;
	bh=Ta9ywsfJdQ6Vo9GcVw9UdsJhBf8GeU+PxCzAYoUhaiw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=B5afochU0/mXPscEMpp4ziT4IROa+oxWVIIhRWK6E1UftGGqRGPbt38kD+oGyEWcNt3XosRT56yI0cI/T0DnM6ll+RnwxR0a73xvNXe/eBwgh9y6w5Vt1rHdojA/IbUQsediOo3jc7KfMj7cHNck4qk7eSf7WW0ivgTR6W1hLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io; spf=pass smtp.mailfrom=tuta.io; dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b=OHLw6czj; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 85753434B591;
	Thu,  5 Dec 2024 20:22:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733426566;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=Ta9ywsfJdQ6Vo9GcVw9UdsJhBf8GeU+PxCzAYoUhaiw=;
	b=OHLw6czj0xmx5L9NlIGK42fFoyoKF1TfdRuocBO6cv8+WfqO21MfRpqzW5gFpjgu
	r4VBJPAiqYV4kLvQTllsUjqZUwb92GWvYJ3yvbssABhdbTG36yC2xUn49KBfgLjfmoN
	orU/ix3Hy9YHsaY4FmjpipjqKvkF0aJHStk0uXQwVMfAeYPMD28ZRkP99m5sUz1Fqze
	/c8E6QQRpNDRSg0o96BpfSoig78A9/vlav4Azt+LNJVcg612cJpY6nkD+UQqTFpu7uv
	OFxZtiyC1DVnRWkShmdXkC+EVQLUwgPfh9F5EXpfUyH2gPwogy7ewgnyYWQKoVmqVkU
	jvSt1QuNmA==
Date: Thu, 5 Dec 2024 20:22:46 +0100 (CET)
From: jens.korinth@tuta.io
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rust For Linux <rust-for-linux@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <ODNG_IK--F-9@tuta.io>
In-Reply-To: <CANiq72kRiWoo510U8gkLDpyhNi=a1Ps034Dcid5jvLxJnbNRMQ@mail.gmail.com>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io> <20241126-pr_once_macros-v4-3-410b8ca9643e@tuta.io> <CANiq72m-dY0b7UiBiWOg8g1SFPqLxuhkDdWwNh8g8OBk-Tjz=w@mail.gmail.com> <OCjLJ1h--F-9@tuta.io> <CANiq72=A9=uzSt9DOZBvw3sHwf4vqX2+6MBDKO5FokZUyt1V3A@mail.gmail.com> <ODKVmiV--F-9@tuta.io> <CANiq72kRiWoo510U8gkLDpyhNi=a1Ps034Dcid5jvLxJnbNRMQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rust: error: Replace pr_warn by pr_warn_once
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Sorry, I am confused. This is not implementing the `From` trait, it is
> an inherent implementation.

Hmm, you're right. I assume there is a reason why it doesn't implement
`From<c_int>` or `TryFrom<c_int>`?

> If what you mean is that this should not be an infallible operation,
> then we are back at my previous reply, i.e. are you suggesting to
> remove the method? Could you please clarify, perhaps with an example?

Yes, I meant to say it should not be infallible, because, well, it isn't. :)
I'd probably make `try_from_errno` public and remove `from_errno`.

If there's no other disadvantage I'd remove `try_from_errno` as well and
replace it by `TryFrom<c_int>`. Implementing `From<Error> for c_int` may
also make sense for the other direction?

Jens

