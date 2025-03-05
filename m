Return-Path: <linux-kernel+bounces-546638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68BBA4FD2C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DC81892045
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C5233D8D;
	Wed,  5 Mar 2025 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Y2XR3HLJ"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8661F22E017
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172766; cv=none; b=XuM18RPRZWbmrkCV+6VCAYAxvAnP63pKgfRag9cHnj7T+fBVMhzTI/owE341GpHz/WLlO26Uh7uCJRy01gmocAc9yW8yzJEf7aUh4Pny2JexbWEWUkX/nuqctJ5KJ5QUXkF/Fae7on3yXVz4pEGAW7kBwN99J9KGg++te6g1JE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172766; c=relaxed/simple;
	bh=8BfkhJEiX567lk23hTtlFCn+C7rzGcjUSqBPr5QYbIk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJoXOD5obJ9mIXzx5QvEFTurH4GFy8E49vtvgEdq1yuEaNXXNJnX0X+SQeF58R2e/KPZAYt71Wv0H940K7ja++jZlltVDxX3wK3LqsxjiLwYQVEloKL40G6b6L55QUb0P4ZQWIV1rYG5jBCOXUrSDNTFQ1ca1zmDPXHcQ+kxPzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Y2XR3HLJ; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741172762; x=1741431962;
	bh=8BfkhJEiX567lk23hTtlFCn+C7rzGcjUSqBPr5QYbIk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Y2XR3HLJZxImjI6VsoA13bF4VG65TMMSQ00iLI1UHnBzgMR9Cr+a9+eXSclEgCDl8
	 JAiii5dx/TTQ+UtHNepf9jYYXpRhoHt81hZeKLn0FmzMXPYZeVxVd1UXU/WT+VdmXg
	 XnWM3PE86iHGElqMRH27hXqpryDYRUZzIQkfnWmczaJiFEXSKAkf2/fGqjUzwS4exb
	 MzdN/5XdPqr3jjeSQ5v8aNV1V7UGweRmJxCpS53WO1OGoKocGjpANmYzpQshklYrvU
	 OkaCygYgTt7ZlD4nz3E4Fot5nqg0eRnz8hKJRQ3BecpaBjS3R+ifhocrPBrHXF+NWk
	 GVnxcw0dqLzMA==
Date: Wed, 05 Mar 2025 11:05:55 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/22] rust: pin-init: move proc-macro documentation into pin-init crate
Message-ID: <D88A875SAHW1.GMXBFL84SI6D@proton.me>
In-Reply-To: <878qpjg6sj.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <PvTMOxu_O9hNZCnpZRlYj2yIiGONO7aZxT7F9mqfOwEMfFnE6ucILMz4aGehSJwWOKtsieqIrh__hd1b5T3z8w==@protonmail.internalid> <20250304225245.2033120-5-benno.lossin@proton.me> <878qpjg6sj.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 110abc0108e199aa7e9f70b2a80c5a7d5c03e2c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 10:34 AM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> Move the documentation of proc-macros from pin-init-internal into
>> pin-init. This is because documentation can only reference types from
>> dependencies and pin-init-internal cannot have pin-init as a dependency,
>> as that would be cyclic.
>
> `pin_data` et. al. is now re-exported both in `kernel::prelude` and
> `kernel::init`, but I guess that is fine?

Yes, that is fine, later the imports will be resolved such that the
prelude re-exports the macros from the pin-init crate (so the docs
should also be rendered there).

> When you say "can only reference types", do you mean via links in the tex=
t?

Yes, I mean the doc-links, e.g. [`Zeroable`].

---
Cheers,
Benno


