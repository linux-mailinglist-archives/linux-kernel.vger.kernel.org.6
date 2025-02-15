Return-Path: <linux-kernel+bounces-516264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A810A36ED4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 15:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D325816B2F4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BF719ABD8;
	Sat, 15 Feb 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ITQPEozr"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8BBE49
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739630091; cv=none; b=MY0ixruUjDWp12r7ftkU4pRAjIfpfo9J6qtEBFem5BqJvhnjOuYkeCTooG/o9Vk6r5fGFOJBiU6cMK8ukBscHXJSDH/hSjEHlS2KXl9fTvVeF3rUwjCTF9QaF0gIlxYZm5XYYdoIzgNSbOYchCXabHIv6A8yXDQFSgRDx1PEIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739630091; c=relaxed/simple;
	bh=92ocfrlLvJ23Or9dYf17grChdOmx8/wSNq8Pz3+AXWg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYuwfPiQq5+mM+GHpHZQ+Fbm1JD3O7dxNxbF6+DXRox1roGZCv6ZTU6FlNihBXncayeROIwgKDnxNZ9/NkSEu8OReKtEVMmJNhz0Z7fyTiutDYEjUMzMTpAWc6pqCsD8m4BBrGFEwaVR59lT3nvq7JzCj48s/6se3a9KWVztjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ITQPEozr; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1739630080; x=1739889280;
	bh=92ocfrlLvJ23Or9dYf17grChdOmx8/wSNq8Pz3+AXWg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ITQPEozrjX3ZxHYv4fMgQzdQ94ZDWhQ6olbLpdiKpptxS14SxSi0QZAfEnu3VhUEG
	 gjv1uwIHm3ZyI53awpSo2n+DYllViJfOF/+auFugMERYVzAZDSckDHXk8DxVeqbQ+s
	 +fZTVhgwS1MAjBE/63o+eE86Oi9VM+rt+sAGq4nuv3GVmpT9PDYLjIxdH0f9+joaKN
	 Pa6SMO29gsPCLXEzT40yr3djAtDMNTYxHE7iylRSozFYDLnyj+T0QGP0wRL2cDK3Yu
	 xgNVXsYWFQkrrWP7UCAMuPqIRloZOb+k+m0NX/2qToPFXDdNAVVzIygKMgN4mj3GHs
	 e39F459FGoABg==
Date: Sat, 15 Feb 2025 14:34:36 +0000
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, gregkh@linuxfoundation.org, joe@perches.com, linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, miguel.ojeda.sandonis@gmail.com, ojeda@kernel.org, pbonzini@redhat.com, rust-for-linux@vger.kernel.org, tmgross@umich.edu, walmeida@microsoft.com
Subject: Re: [PATCH V2 1/2] rust: module: change author to be a array
Message-ID: <32437338-a050-46ec-a09a-faf73a6b477b@proton.me>
In-Reply-To: <20250215135229.300420-1-trintaeoitogc@gmail.com>
References: <93eaeb37-9913-49cb-be6d-367696a81baf@proton.me> <20250215135229.300420-1-trintaeoitogc@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7a1e6b8dbee201addc2f6954ffa234f86dd71e4a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.02.25 14:52, Guilherme Giacomo Simoes wrote:
> Benno Lossin <benno.lossin@proton.me> wrote:
>> As already mentioned above, I think it makes sense to also rename the
>> field to `authors`.
> When I maked this change, I thinked in change the field name from author =
to
> authors, but I don't doing this because anothers fields that is a array i=
n
> module! macro (firmware and alias) are in singular too.

Hmm IMO the `alias` field should also probably be called `aliases`
(though not in this patch). And I believe that the plural of `firmware`
also is `firmware`.
So I still think it's a good idea to rename it to `authors`.

>> You should also change the documentation in this file, there the field
>> `author` is listed as "string literal of the author of the kernel
>> module.", so it also needs to be updated.
> Yes, you is right... I haven't seen this chunk of text

No worries, that's what review is for.

---
Cheers,
Benno


