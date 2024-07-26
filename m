Return-Path: <linux-kernel+bounces-263315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAE593D43A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589A91C23241
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94617BB3F;
	Fri, 26 Jul 2024 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XUbN4jkB"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8A8176AAE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001040; cv=none; b=li01z4voFuoLVX2AspayzSVrGC/iSKCl4kHjZUL2O7+QeMTnNPAhE1jmdzcw/LNvD2gKEvB12Tqae81TNhl+b5/ChH89KpKd0gqlzmyIPcbEVg8NOgoOu3u+MVE6fJWemqbo0lkHE8S2cRBbEehuQp8S/t9KhMwGSF/PTuK2XDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001040; c=relaxed/simple;
	bh=wkrRH9dGtHLO1NQB8yO/jdTXC+vGKyvD0lxyFAGQEA4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcckySNhN6I/c4RZOVLFSROd95BQXeb0bOMsCeXhJVWksUjijN1yXReE+tNycWQfWoAH46qmLZC6RKJmIeYTSdpzBAqcL9hIgRhM8XmP7YBZovx8BlE3LeJthIx8OTUdksxg+em2xrMJuKEwVvE0ywQ8CT+1kkM+Uqxrn/FZ400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XUbN4jkB; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722001036; x=1722260236;
	bh=wkrRH9dGtHLO1NQB8yO/jdTXC+vGKyvD0lxyFAGQEA4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XUbN4jkBedgBI4LfcoOmI0x1oQPIy9qibJ76jbaREdroyCaQJ5wT7IQfQQ0CcJgDg
	 PkIW6Efo91I/AZV1tYkgaA8fP8kQuq7qKzzoBzG3fe6gs51wo81n+Fb2EwI7ct8SJw
	 NyOJdYSq6jb0CoFpHwXMFhhUylO6LHOJ96nC+vYZW8JXX5H23jM7o1Kh6cqQTC1Dkm
	 u/WZQ1cPUTT/Ua2s+FlgpJF95ZM2yqzrgdK78Loso7tKDGBSQbpxLvH37DRADEoFch
	 rFJZKYv9yF4ZFWt0mSO7Mwn593DOqZtRhtss7P+nKvzkNPkTTvq13Gacb0pHpD4fci
	 N4TI5gdMWQa4A==
Date: Fri, 26 Jul 2024 13:36:57 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: mm: add abstractions for mm_struct and vm_area_struct
Message-ID: <b7e8b816-a3c1-454c-bf97-516bf78c697c@proton.me>
In-Reply-To: <CAH5fLgjfiE6xNpKVBAgXu=eFyE65k+RxWqNt10J+44pK-mJgTw@mail.gmail.com>
References: <20240723-vma-v1-1-32ad5a0118ee@google.com> <3bf6bfdc-84af-442a-acec-a58f023d1164@proton.me> <CAH5fLgjfiE6xNpKVBAgXu=eFyE65k+RxWqNt10J+44pK-mJgTw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 728504dfe84b34776ea12199d7f14710ca63044d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.07.24 10:32, Alice Ryhl wrote:
> On Fri, Jul 26, 2024 at 10:11=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> On 23.07.24 16:32, Alice Ryhl wrote:
>>> This is a follow-up to the page abstractions [1] that were recently
>>> merged in 6.11. Rust Binder will need these abstractions to manipulate
>>> the vma in its implementation of the mmap fop on the Binder file.
>>>
>>> The ARef wrapper is not used for mm_struct because there are several
>>> different types of refcounts.
>>
>> I am confused, why can't you use the `ARef` wrapper for the different
>> types that you create below?
>=20
> Well, maybe I can, but it means we have several wrapper structs of
> Opaque<mm_struct>. Would it not be confusing? Could you suggest a
> naming scheme for the structs I should have?

I don't know of a good way to avoid that, IMO your current
implementation has the same issue (multiple wrappers). So I don't think
it's that bad to have multiple wrappers for one C struct.
We could also use generics to solve this, right? I am not sure about the
ergonomics/looks, so for example:
- ARef<Mm<Grab>>
- ARef<Mm<Get>>
- ARef<Mm<Async>>

I think it looks fine, then you also only have one struct wrapper.

BTW what does "mm" stand for? Memory management?

---
Cheers,
Benno


