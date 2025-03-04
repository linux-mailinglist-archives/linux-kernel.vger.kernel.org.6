Return-Path: <linux-kernel+bounces-544202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 659BAA4DEA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD301899A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FDA2045BD;
	Tue,  4 Mar 2025 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIDq6pa8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A720459C;
	Tue,  4 Mar 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093540; cv=none; b=gAeDsJfdT7dxfT5kw0NOb0FUa2eyCMsMfYaq0HiQRNm6JLAYgDPlXfSN2Itw/JZesJATty/1Ife1L+fVpWLjgspP2N7Ub4aSCzjhZ7HEA5Y6KeYVsGO+zGBHqvrM/ieZeoUwNbC40pwpbaS+E0Ajol4GOIqqXO8Uc7JFbH7FYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093540; c=relaxed/simple;
	bh=/hYyrQ2sE0sxso9ZZN/O7DYTDmYaM4mWwlCH1iQvqws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHzmZQsRX4YwkALhBX5SiAYzgVyhrGz56ECLf9fEpTkWQQOA7vW52bdLE4nSKWoJErvaN5KVQ+eMo1nQaeKqj10AI6GugMz/xntXT3esTp9he1SLUY0tgJMtJKrSbgQXvahBteuyWyXYUDc6AWOUSzZn+g1sPf1eLdtXSjg1PB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIDq6pa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074A3C4CEEB;
	Tue,  4 Mar 2025 13:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741093539;
	bh=/hYyrQ2sE0sxso9ZZN/O7DYTDmYaM4mWwlCH1iQvqws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nIDq6pa8MRk0px2SVcAOx9n0irgTb92yYTyl22RmnidnY8CCSTF80e+j0Q4TYAznq
	 0DgKmkqzDP8mxxYNm6sel3GfCe1NreOrUgbryMvkUz/Hx10N3Hnv7syRwXyrD1OtAd
	 fFNMzNlNB39r+5/169v3WKyu3sYxrNkFJaST4e9BTmgavLDy/WleBdtnbwcuRP0gjv
	 YFW6JNNAJF623ozF8gMtIhpHwjlctoHyoojANYT7SZLbPrUWkOvexz4ELIP+EIwmVT
	 OKWSDwUiOTNvM3bBCx2Mne5Q1lwU5NaYh+i3sqfytVOVLc6MwbUoHoXxh7rUeReCo9
	 YXnOedeMNZXVg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: "Christian Schrefl" <chrisi.schrefl@gmail.com>,  <ojeda@kernel.org>,
  <alex.gaynor@gmail.com>,  <boqun.feng@gmail.com>,  <gary@garyguo.net>,
  <bjorn3_gh@protonmail.com>,  <benno.lossin@proton.me>,
  <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  "Alice Ryhl" <aliceryhl@google.com>
Subject: Re: [PATCH v2] rust: irq: add support for request_irq()
In-Reply-To: <30401DE8-53DA-4CF3-9D97-1511015BCD4D@collabora.com> (Daniel
	Almeida's message of "Thu, 23 Jan 2025 13:27:35 -0300")
References: <20250122163932.46697-1-daniel.almeida@collabora.com>
	<8a2bac6e-1989-41d8-a5f6-3bb518a9f139@gmail.com>
	<nq_iZCUO9wlw_7XpnwruhxrOfFrbYH67DXh28uk52uNdDzLayvIYZTMBCvKask7cZsNMwl61CATm40xjmeqTPA==@protonmail.internalid>
	<30401DE8-53DA-4CF3-9D97-1511015BCD4D@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 04 Mar 2025 14:05:23 +0100
Message-ID: <87o6yhgd4c.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Hi Christian,
>
>> On 23 Jan 2025, at 13:00, Christian Schrefl <chrisi.schrefl@gmail.com> w=
rote:
>>
>> On 22.01.25 5:39 PM, Daniel Almeida wrote:
>>> Add support for registering IRQ handlers in Rust.

[...]

>>> +/// The flags that can be used when registering an IRQ handler.
>>> +pub mod flags {
>>
>> Maybe move flags into a separate file?
>> You even have a directory for irq.
>
> Why? Most flags are defined in the same file. See alloc::flags, for examp=
le.
>
> I am not against this, but since this is merely aesthetic in nature, we s=
hould maybe
> wait for input from more people.

I would prefer them in another file as well. Not a hard requirement though.

[...]

>>> +///     // This will run (in a separate kthread) iff `handle_irq` retu=
rns
>> typo iff
>
> I mean the acronym for =E2=80=9Cif and only if=E2=80=9D.

Since it is not immediately obvious to all readers, prefer "if and only
if". I think we discussed this at pin-init patches a long while ago.


Best regards,
Andreas Hindborg



