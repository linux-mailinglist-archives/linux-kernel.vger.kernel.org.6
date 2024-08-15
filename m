Return-Path: <linux-kernel+bounces-288482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA52953A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E6ABB2569F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1372145FFE;
	Thu, 15 Aug 2024 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dtdNWwRY"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A05770FB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748896; cv=none; b=jkkgkkweQHmCJmhgLepIVEMHhfuIINiWKulAHso2ihZhX8FN0JWLgi2/xN+yWWZ6HFOFFJUXsn2xuipFAKB0qI6QFwRaQv6bS8tEDQntukRfA2MuY2l4TRZyo+864GqejB8T94eJ9EQ//DyYTtUaRWNLfVcR+vkIPHjJorcnvus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748896; c=relaxed/simple;
	bh=0ozggr77TSIkab1vrhgR73woDMghC/BCCc6vgLBxdr0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPywvbfHsADmLwAJhqBhjo3BRIHdlDOUUZI8hBHFATizIkCLVx/a3JY9ySrXfdB211gLTXMYs28lYxgvYcOoxoYy/Q6LgVsMZd4RF055FCQi8l6DED1bamcv8Ny4TxaLIkzJsOU3J76pyIZ+x4aSkHsCMEOLZu5sX7mLQ7VxUUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dtdNWwRY; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723748887; x=1724008087;
	bh=0ozggr77TSIkab1vrhgR73woDMghC/BCCc6vgLBxdr0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dtdNWwRYXesRJQkZUlaNUCVEPKgakblWm1jHWX0cJLCJP8Pd7uzUZ3prpdRAED0Zy
	 f/2WaNfMPp4/WTYtRtsJ9RmHHjJayky8Jpthcn4rYkE9hvRcA2MRxSeIUHPG05lOSu
	 mdjtKAEgBfRVl6BEu2/6YuNUb6SvkNdysF6gYUCMQkYlooWzpK9nttRWUU20Rf4cTj
	 CFVm/Vh9enF1j66a/lAuahAY3z8FHO8ozaGOzL7cvYqzrpMCOeQZFN9Io81gY91prq
	 qXCT5wXDqWnc9AXbQVFWLAULnJVTlhqg66Mww1rygp9MERXZwt0FHhH3XHCUS2gHNb
	 x1RWnilrdwRkg==
Date: Thu, 15 Aug 2024 19:08:02 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 06/26] rust: alloc: implement `Vmalloc` allocator
Message-ID: <c693cfad-f3e4-48e8-820c-16bc3d9f46ab@proton.me>
In-Reply-To: <Zr4PSuIOpiE-8OkJ@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-7-dakr@kernel.org> <c9d57e77-8748-4e58-a39b-7a23f750ceda@proton.me> <Zr0r6sSFMSQIpHEX@cassiopeiae> <Zr072oSej9KIc1S6@cassiopeiae> <5dfe8bae-2c1e-47d4-9fb4-373b7d714c4f@proton.me> <Zr30pNwc5aanRaqj@cassiopeiae> <01a46c6d-0107-4455-8c87-af43426752ff@proton.me> <Zr4PSuIOpiE-8OkJ@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 52564aee61cdea9f9328fff33fb3ea771ee2a636
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 16:23, Danilo Krummrich wrote:
> On Thu, Aug 15, 2024 at 01:44:27PM +0000, Benno Lossin wrote:
>> On 15.08.24 14:29, Danilo Krummrich wrote:
>>> On Thu, Aug 15, 2024 at 06:48:19AM +0000, Benno Lossin wrote:
>>>> On 15.08.24 01:20, Danilo Krummrich wrote:
>>>>> On Thu, Aug 15, 2024 at 12:13:06AM +0200, Danilo Krummrich wrote:
>>>>>>> How difficult will it be to support this? (it is a weird requiremen=
t,
>>>>>>> but I dislike just returning an error...)
>>>>>>
>>>>>> It's not difficult to support at all. But it requires a C API taking=
 an
>>>>>> alignment argument (same for `KVmalloc`).
>>>>
>>>> I see, that's good to know.
>>>>
>>>>>> Coming up with a vrealloc_aligned() is rather trivial. kvrealloc_ali=
gned() would
>>>>>> be a bit weird though, because the alignment argument could only be =
really
>>>>>> honored if we run into the vrealloc() case. For the krealloc() case =
it'd still
>>>>>> depend on the bucket size that is selected for the requested size.
>>>>
>>>> Yeah... Maybe some more logic on the Rust side can help with that.
>>>
>>> Only if we reimplement `KVmalloc` in Rust, However, there are quite som=
e special
>>> cases in __kvmalloc_node_noprof(), i.e. fixup page flags, sanity check =
the size
>>> on kmalloc failure, fail on certain page flags, etc.
>>>
>>> I don't really want to duplicate this code, unless we absolutely have t=
o.
>>
>> I am under the (probably wrong) impression that kvmalloc has some size
>> check and selects vmalloc or kmalloc depending on that.
>=20
> Basically, yes. But as mentioned above, there are quite some corner cases=
 [1].
>=20
>> I think that we
>> could check the size and if it is going to allocate via kmalloc, then we
>> adjust the size for alignment as usual
>=20
> We don't need this adjustment any longer, see commit ad59baa31695 ("slab,=
 rust:
> extend kmalloc() alignment guarantees to remove Rust padding").
>=20
>> and if it is going to select
>> vmalloc, then we can just pass the alignment (if the vmalloc alignment
>> patch is done first).
>=20
> Yeah, but as mentioned, I'd prefer to do this in C, such that we don't ne=
ed to
> open code everything the C code already does.
>=20
> [1] https://elixir.bootlin.com/linux/v6.11-rc3/source/mm/util.c#L628

I see, then it's probably better to just add an align parameter variant
on the C side. Instead of rebuilding it in Rust.

---
Cheers,
Benno


